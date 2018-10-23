
# Values needed by build.sh, run.sh, and the Apache configuration are set in
# environment variables.
#
# NOTE: you probably won't need to edit this
#
#
# mod_auth_mellon needs the SAML metadata (for IdP and mellon itself) in
# files on the filesystem. For the moment I generate those files and copy them
# into the image when building it (in build.sh).
# This differ from my OIDC container which gets everything from the ENV at
# at runtime.
#
# At some point I will probably redesign that so that the files are shared
# from the host, but this is just for me at this point so there's no need
# to get fancy.


# URL to your IDCS tenancy
#IDCS_SERVER_URL=https://YOURIDCSURL.identity.oraclecloud.com
IDCS_SERVER_URL=`idcs config show -setting=idcsURL`

# docker image name
IMGNAME=therealcmj/samltest

# what port should Docker listen on?
HTTP_LISTEN_PORT=8081

# the URL of this container plus the protected directory plus a little nonsense
OIDC_REDIRECT_URL=http://localhost:${HTTP_LISTEN_PORT}/protected/redirect_uri/

# this is only used by the CLI script
IDCS_APPNAME="IDCS_DockerSAMLTest"
