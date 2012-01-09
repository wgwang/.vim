#!/usr/bin/env python3

##############################################################################
#
# Vim Script Updater 1.0
#
# Author: David Munger
#
##############################################################################

import urllib.request, urllib.error, urllib.parse
import sys, os, re, io
import atexit
import shutil
import tempfile
import gzip, bz2, tarfile, zipfile

from html.parser import HTMLParser, HTMLParseError


VIM = 'vim'


class TempDir: # {{{1

    def __init__(self):
        """create a temporary directory"""
        self.path = tempfile.mkdtemp()

    def __del__(self):
        """delete everything in the temporary directory and the directory itself"""
        shutil.rmtree(self.path)

    def mktmpfile(self):
        """create a temporary file and return it"""
        return tempfile.mkstemp(dir=self.path)

    def mktmpdir(self):
        """create a temporary subdirectory and return it"""
        return tempfile.mkdtemp(dir=self.path)

    def mkdir(self, reldir):
        """recursively creates a directory
        return the full path to the new directory"""
        fullpath = os.path.join(self.path, reldir)
        if len(reldir) != 0:
            os.makedirs(fullpath)
        return fullpath

    def move(self, path, new_path):
        """moves a file or a directory
        return the full path to the target"""
        target = os.path.join(self.path, new_path)
        shutil.move(os.path.join(self.path, path), target)
        return target

    def download(self, url, filename):
        """download to temporary directory with specified filename (or subpath)
        if filename contains a subpath, it will be created automatically
        return the full path to the target path on success
        """

        u = urllib.request.urlopen(url)
        if u.info()['content-type'].startswith('text/html'):
            raise Exception('Cannot download URL: %s' % u.geturl())

        self.mkdir(os.path.dirname(filename))
        target = os.path.join(self.path, filename)

        f = open(target, 'wb')
        f.write(u.read())
        f.close()

        return target




class VimScriptHTMLParser(HTMLParser):

    def __init__(self, url=None):

        HTMLParser.__init__(self)

        self._tag_stack = []
        self._td_count = 0
        self._cur_info = None
        self.charset = 'utf-8' # default charset

        self.script_info = []
        self.url = url
        self.script_id = 0

        if url is not None:

            # detect script ID
            m = re.search('\\bscript_id=(\d*)', url)
            if m: self.script_id = m.group(1)

            # parse URL
            for line in urllib.request.urlopen(url):
                self.feed(line.decode(self.charset))

    def latest_script(self):
        return self.script_info[0]

    def handle_starttag(self, tag, attrs):

        self._tag_stack.append(tag)

        if tag == 'meta':
            attrs = {k.lower():v.lower() for k,v in attrs}
            if attrs.get('http-equiv', '').lower() == 'content-type':
                values = [s.strip() for s in attrs.get('content', '').split(';')]
                for v in values:
                    if v.startswith('charset='):
                        self.charset = v.split('=', 1)[1]
        elif tag == 'tr':
            self._td_count = 0

        elif tag == 'a' and self._tag_stack[-2] == 'td':

            if self._td_count == 0:
                for key, val in attrs:
                    if key == 'href':
                        if re.match('download_script\.php\?src_id=', val):

                            # detect source ID
                            m = re.search('\\bsrc_id=(\d*)', val)
                            if m:
                                self._cur_info = ScriptInfo()
                                self._cur_info.sid = int(self.script_id)
                                self._cur_info.src_id = m.group(1)


    def handle_data(self, data):

        if len(self._tag_stack) < 2:
            return

        if not self._cur_info:
            return

        if self._tag_stack[-2] == 'td':
            if self._td_count == 0:
                self._cur_info.filename = data
            elif self._td_count == 1:
                self._cur_info.version = data
            elif self._td_count == 2:
                self._cur_info.date = data


    def handle_endtag(self, tag):

        while self._tag_stack.pop() != tag:
            pass

        if tag == 'tr' and self._cur_info:
            # flush stored script info
            self.script_info.append(self._cur_info)
            self._cur_info = None
            self._td_count = 0

        elif tag == 'td':
            self._td_count += 1


class ScriptInfo:

    BASE_URL = 'http://www.vim.org/scripts'

    def __init__(self, strdef=None):

        self.sid = 0
        self.prefix = ''
        self.filename = ''
        self.version = ''
        self.date = ''
        self.src_id = 0

        if strdef:
            m = re.match('([0-9]*)(\|([^\|]*)(\|([^\|]*)\|([^\|]*)\|([^\|]*)\|([^\|]*))?)?',
                    strdef.strip())
            if m:
                self.sid        = int(m.group(1))
                self.prefix     = m.group(3)
                self.filename   = m.group(5)
                self.version    = m.group(6)
                self.date       = m.group(7)
                self.src_id     = m.group(8)

    def to_string(self):
        return '|'.join(map(str, [self.sid, self.prefix, self.filename, self.version, self.date, self.src_id]))

    def url(self):
        return self.BASE_URL + '/script.php?script_id=' + str(self.sid)

    def src_url(self):
        return self.BASE_URL + '/download_script.php?src_id=' + str(self.src_id)

    def update(self):

        # download new script info
        parser = VimScriptHTMLParser(script.url())
        s = parser.latest_script()
        s.prefix = self.prefix
        return s

    def download(self, tmpdir):

        return tmpdir.download(self.src_url(), self.filename)
        


class WatchList: # {{{1

    def __init__(self):
        self.scripts = {}

    def __iter__(self):
        return iter(self.scripts.values())

    def __getitem__(self, key):
        return self.scripts[key]

    def __setitem__(self, key, value):
        self.scripts[key] = value


    def read(self, source):
        if isinstance(source, io.TextIOBase):
            for line in source:
                script = ScriptInfo(line)
                if script.sid:
                    self.scripts[script.sid] = script
                else:
                    print('warning! skipping line:', line)
        else:
            raise Exception('WatchList.read(): unknown source type')


    def write(self, dest):
        if isinstance(dest, io.TextIOBase):
            for script in self.scripts.values():
                dest.write(script.to_string() + '\n')
        else:
            raise Exception('WatchList.write(): unknown destination type')


class VimBall: # {{{1

    def __init__(self, filepath, tmpdir, prefix=None):
        """convert file to vimball using temporary directory"""

        self.scriptname = re.sub('\.(tar\.gz|tar\.bz2|tgz|zip|gz|bz2|vba|vim)$', '',
                os.path.basename(filepath))

        filepath = self._uncompress(filepath)

        if filepath.lower().endswith('.vba'):
            self.vbapath = filepath
        else:
            self._create_vba(filepath, tmpdir, prefix)


    def _uncompress(self, filepath):

        filelower = filepath.lower()

        if filelower.endswith('.gz'):
            f = gzip.open(filepath)
            filepath = filepath[:-3]
            f2 = open(filepath, 'w')
            f2.write(f.read())
            f.close()
            f2.close()
        elif filelower.endswith('.bz2'):
            f = bz2.BZ2File(filepath)
            filepath = filepath[:-4]
            f2 = open(filepath, 'w')
            f2.write(f.read())
            f.close()
            f2.close()

        return filepath


    def _create_vba(self, filepath, tmpdir, prefix=None):

        vbadir = tmpdir.mktmpdir()
        dstdir = vbadir

        if prefix:
            dstdir = os.path.join(vbadir, prefix)
            os.makedirs(dstdir)

        filelower = filepath.lower()

        if filelower.endswith('.tar') or filelower.endswith('.tar.gz') or \
                filelower.endswith('.tar.bz2') or filelower.endswith('.tgz'):
            f = tarfile.open(filepath)
            f.extractall(dstdir)
            f.close()
        elif filelower.endswith('.zip'):
            f = zipfile.ZipFile(filepath)
            f.extractall(dstdir)
            f.close()
        else:
            filepath2 = os.path.join(dstdir, os.path.basename(filepath))
            shutil.move(filepath, filepath2)

        # create file list
        listpath = os.path.join(tmpdir.path, 'vbalist.txt')
        f = open(listpath, 'w')
        f.writelines([s + '\n' for s in self.findfiles(vbadir)])
        f.close()

        # create vimball
        self.vbapath = os.path.join(tmpdir.path, self.scriptname + '.vba')
        status = os.system("%s -e -c '%%MkVimball! %s %s' -c 'qa!' %s" % (VIM, self.vbapath, vbadir, listpath))
        if status:
            raise Exception('cannot create vimball %s' % self.vbapath)


    def findfiles(self, basedir, reldir=''):

        files = []
        fulldir = os.path.join(basedir, reldir)

        for item in os.listdir(fulldir):

            fullpath = os.path.join(fulldir, item)
            relpath = os.path.join(reldir, item)

            if os.path.isfile(fullpath):
                files.append(relpath)
            else:
                files += self.findfiles(basedir, relpath)

        return files

    def install(self):
        status = os.system("%s -e '%s' -c 'so %%' -c 'qa!'" % (VIM, self.vbapath))
        if status:
            raise Exception('cannot install vimball %s' % self.vbapath)


def confirm(question): # {{{1
    """Return true if the answer is 'y'"""

    ans = 'x'
    while not ans in ['y', 'yes', 'n', 'no']:
        ans = input(question + ' [y/n] ')

    return ans.lower() in ['y', 'yes']



def usage(): # {{{1
	print("""usage: %s watch-list [...]

	where watchlist is a file containing one or more lines with the following
	syntax:
	    script ID
	or
	    script ID|prefix

	Example file:
	    42
	    1259|colors
	    3096|plugin
	    3108"""  % (os.path.basename(sys.argv[0])))



if __name__ == '__main__': # {{{1

    if len(sys.argv) < 2:
        usage()
        sys.exit(1)

    # temporary directory is global
    global tmpdir
    tmpdir = TempDir()

    def on_exit():
        global tmpdir
        del tmpdir

    atexit.register(on_exit)


    try:
        for filename in sys.argv[1:]:

            watchlist = WatchList()

            # read watch-list
            watchlist.read(open(filename))

            for script in watchlist:

                # update script info
                try:

                    new_script = script.update()

                    if new_script.src_id != script.src_id:

                        print('%s updated from version %s to %s on %s' % (new_script.filename, script.version,
                                new_script.version, new_script.date))

                        if not confirm('download and install %s?' % new_script.filename):
                            continue

                        vimball = VimBall(new_script.download(tmpdir), tmpdir,
                                prefix=new_script.prefix)

                        # attempt upgrade
                        vimball.install()
                        
                        # commit to watch-list
                        watchlist[new_script.sid] = new_script
                        f = open(filename, 'w')
                        watchlist.write(f)
                        f.close()

                    else:
                        print('%s is already up-to-date' % new_script.filename)


                except HTMLParseError as e:
                    print('Error update script information for %s (%d)' % (script.filename, script.sid))
                #except Exception as e:
                #    print(e)

    except KeyboardInterrupt:
        print('\ninterrupted by user')

    sys.exit(0)


# vim:fdm=marker
