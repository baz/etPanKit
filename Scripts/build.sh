#!/bin/sh

builddir="$HOME/EtPanKit-Builds"
BUILD_TIMESTAMP=`date +'%Y%m%d%H%M%S'`
tempbuilddir="$builddir/workdir/$BUILD_TIMESTAMP"
mkdir -p "$tempbuilddir"
rootdir="$tempbuilddir/src"
srcdir="$rootdir/etPanKit"
logdir="$tempbuilddir/log"
resultdir="$builddir/builds"

mkdir -p "$resultdir"
mkdir -p "$logdir"
mkdir -p "$srcdir"

etpankitsvnurl="https://libetpan.svn.sourceforge.net/svnroot/libetpan/etPanKit/trunk"

svn co -q "$etpankitsvnurl" "$rootdir/etPanKit"

cd "$srcdir"

buildversion=`svn info | grep Revision | sed 's/Revision: //'`
#echo $rev

echo building etPanKit - $buildversion

version=`defaults read "$srcdir/Info" CFBundleShortVersionString`
defaults write "$srcdir/version" CFBundleVersion $buildversion
defaults write "$srcdir/version" CFBundleShortVersionString $version
defaults write "$srcdir/Info" CFBundleVersion "$buildversion"

/Developer/usr/bin/xcodebuild -target etPanKit -configuration Release OBJROOT="$tmpdir/obj" SYMROOT="$tmpdir/sym" RUN_CLANG_STATIC_ANALYZER="NO" >> "$logdir/etpankit-build.log"
if test x$? != x0 ; then
	echo build of etPanKit failed
	exit 1
fi

svn commit -m "build $buildversion" "$srcdir/Info.plist" "$srcdir/version.plist"

cd "$tmpdir/sym/Release"
mkdir -p "EtPanKit-$buildversion"
mv "EtPanKit.framework" "EtPanKit-$buildversion"
zip -qry "$resultdir/EtPanKit-$buildversion.zip" "EtPanKit-$buildversion"

echo build of etPanKit-$buildversion done
