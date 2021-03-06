Name: logtalk
Summary: Logtalk - Open source object-oriented logic programming language
Version: 2.44.1
Release: 1
License: Artistic License 2.0
Group: Development/Languages
Packager: Paulo Moura <pmoura@logtalk.org>
Source: http://logtalk.org/files/lgt2441.tar.bz2
BuildArchitectures: noarch
URL: http://logtalk.org/
AutoReqProv: no
%description
Logtalk is an object-oriented logic programming language that can use most Prolog implementations as a back-end compiler. As a multi-paradigm language, it includes support for both prototypes and classes, protocols (interfaces), component-based programming through category-based composition, event-driven programming, and high-level multi-threading programming.

%prep
%setup -q -c lgt2441 -n lgt2441

%build

%install
rm -rf $RPM_BUILD_ROOT
cd scripts
mkdir -p $RPM_BUILD_ROOT/usr/local
./install.sh $RPM_BUILD_ROOT/usr/local

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
%doc /usr/local/share/lgt2441/BIBLIOGRAPHY.bib
%doc /usr/local/share/lgt2441/CUSTOMIZE.txt
%doc /usr/local/share/lgt2441/INSTALL.txt
%doc /usr/local/share/lgt2441/LICENSE.txt
%doc /usr/local/share/lgt2441/QUICK_START.txt
%doc /usr/local/share/lgt2441/README.txt
%doc /usr/local/share/lgt2441/RELEASE_NOTES.txt
%doc /usr/local/share/lgt2441/UPGRADING.txt
/usr/local/share/lgt2441/VERSION.txt
/usr/local/share/lgt2441/compiler
/usr/local/share/lgt2441/configs
/usr/local/share/lgt2441/contributions
/usr/local/share/lgt2441/examples
/usr/local/share/lgt2441/integration
/usr/local/share/lgt2441/libpaths
/usr/local/share/lgt2441/library
%doc /usr/local/share/lgt2441/manuals
/usr/local/share/lgt2441/man
/usr/local/share/lgt2441/scripts
/usr/local/share/lgt2441/settings.lgt
/usr/local/share/lgt2441/wenv
/usr/local/share/lgt2441/xml
/usr/local/share/logtalk
/usr/local/bin/logtalk_user_setup
/usr/local/bin/lgt2pdf
/usr/local/bin/lgt2html
/usr/local/bin/lgt2xml
/usr/local/bin/lgt2txt
/usr/local/bin/logtalk_version_select
/usr/local/bin/logtalk_backend_select
/usr/local/bin/bplgt
/usr/local/bin/cxlgt
/usr/local/bin/eclipselgt
/usr/local/bin/gplgt
/usr/local/bin/lplgt
/usr/local/bin/qplgt
/usr/local/bin/sicstuslgt
/usr/local/bin/swilgt
/usr/local/bin/xsblgt
/usr/local/bin/xsb64lgt
/usr/local/bin/xsbmtlgt
/usr/local/bin/xsbmt64lgt
/usr/local/bin/yaplgt
/usr/local/share/man/man1/bplgt.1.gz
/usr/local/share/man/man1/cxlgt.1.gz
/usr/local/share/man/man1/eclipselgt.1.gz
/usr/local/share/man/man1/gplgt.1.gz
/usr/local/share/man/man1/lgt2html.1.gz
/usr/local/share/man/man1/lgt2pdf.1.gz
/usr/local/share/man/man1/lgt2txt.1.gz
/usr/local/share/man/man1/lgt2xml.1.gz
/usr/local/share/man/man1/logtalk_backend_select.1.gz
/usr/local/share/man/man1/logtalk_user_setup.1.gz
/usr/local/share/man/man1/logtalk_version_select.1.gz
/usr/local/share/man/man1/lplgt.1.gz
/usr/local/share/man/man1/qplgt.1.gz
/usr/local/share/man/man1/sicstuslgt.1.gz
/usr/local/share/man/man1/swilgt.1.gz
/usr/local/share/man/man1/xsb64lgt.1.gz
/usr/local/share/man/man1/xsblgt.1.gz
/usr/local/share/man/man1/xsbmt64lgt.1.gz
/usr/local/share/man/man1/xsbmtlgt.1.gz
/usr/local/share/man/man1/yaplgt.1.gz
%exclude /usr/local/share/mime

%post
echo
echo "Installed Logtalk on \"/usr/local/share\"."
echo

echo "Links to the \"logtalk_user_setup\", \"logtalk_backend_select\","
echo "\"logtalk_version_select\", \"lgt2pdf\", \"lgt2html\", \"lgt2xml\","
echo "and \"lgt2txt\" scripts have been created on \"/usr/local/bin\";"
echo "you may need to add this directoryto your execution path."
echo
echo "The following integration scripts are installed for running Logtalk"
echo "with selected back-end Prolog compilers:"
echo
echo "* B-Prolog (version 7.5#8 or later):     bplgt"
echo "* CxProlog (version 0.97.5 or later):    cxlgt"
echo "* ECLiPSe (version 6.0#141 or later):    eclipselgt"
echo "* GNU Prolog (version 1.4.0 or later):   gplgt"
echo "* Lean Prolog (version 2.19.0 or later): lplgt"
echo "* Qu-Prolog (version 8.12 or later):     qplgt"
echo "* SICStus Prolog (versions 3.12.x, 4.x): sicstuslgt"
echo "* SWI-Prolog (version 5.8.0 or later):   swilgt"
echo "* XSB (version 3.3 or later):            xsblgt     (first run must use sudo)"
echo "* XSB 64 bits (version 3.3 or later):    xsb64lgt   (first run must use sudo)"
echo "* XSB MT (version 3.3 or later):         xsbmtlgt   (first run must use sudo)"
echo "* XSB MT 64 bits (version 3.3 or later): xsbmt64lgt (first run must use sudo)"
echo "* YAP (version 6.0.2 or later):          yaplgt"
echo
echo "Links to the Prolog integration scripts can be found on \"/usr/local/bin\"."
echo "Make sure that the Prolog compilers are properly installed and available"
echo "on your execution path."
echo
echo "If you get an unexpected failure when using one of the Prolog integration"
echo "scripts, consult the \"/usr/local/share/logtalk/configs/NOTES.txt\" file"
echo "for compatibility notes or consult the integration script man page."
echo
mkdir -p /etc/profile.d
echo "# Logtalk environment setup" > /etc/profile.d/logtalk.sh
echo "" >> /etc/profile.d/logtalk.sh
echo "# Logtalk installation directory:" >> /etc/profile.d/logtalk.sh
echo "export LOGTALKHOME=/usr/local/share/logtalk" >> /etc/profile.d/logtalk.sh
echo "" >> /etc/profile.d/logtalk.sh
echo "# Default location for Logtalk end-user files:" >> /etc/profile.d/logtalk.sh
echo "export LOGTALKUSER=\$HOME/logtalk" >> /etc/profile.d/logtalk.sh
chmod a+x /etc/profile.d/logtalk.sh
echo "# Logtalk environment setup" > /etc/profile.d/logtalk.csh
echo "" >> /etc/profile.d/logtalk.csh
echo "# Logtalk installation directory:" >> /etc/profile.d/logtalk.csh
echo "setenv LOGTALKHOME /usr/local/share/logtalk" >> /etc/profile.d/logtalk.csh
echo "" >> /etc/profile.d/logtalk.csh
echo "# Default location for Logtalk end-user files:" >> /etc/profile.d/logtalk.csh
echo "setenv LOGTALKUSER \$HOME/logtalk" >> /etc/profile.d/logtalk.csh
chmod a+x /etc/profile.d/logtalk.csh
echo "Defined the following environment variables for all users:"
echo
echo "  Logtalk installation directory: LOGTALKHOME = /usr/local/share/logtalk"
echo "  Default Logtalk user files directory: LOGTALKUSER = \$HOME/logtalk"
echo
echo "You may need to logout and login again or start a new shell in order to"
echo "use the new environment variables."
echo
echo "Users may change the default value of the LOGTALKUSER environment variable"
echo "in their shell configuration files if they already use, or want to use, a "
echo "different location for the Logtalk user files directory. This directory "
echo "is created by running the \"logtalk_user_setup\" shell script, which must"
echo " be run once by each user before using the integration scripts."
echo
if [ -x /usr/bin/update-mime-database ]; then
	mkdir -p /usr/share/mime/packages
	rm -f /usr/share/mime/packages/logtalk.xml
	cp /usr/local/share/lgt2441/scripts/freedesktop/logtalk.xml /usr/share/mime/packages/logtalk.xml
	update-mime-database /usr/share/mime
	echo "Added the Logtalk mime-type to the Shared MIME-info Database."
	echo
fi
echo "Logtalk basic installation completed."
echo

%postun
rm -f /etc/profile.d/logtalk.sh 2> /dev/null
rm -f /etc/profile.d/logtalk.csh 2> /dev/null
