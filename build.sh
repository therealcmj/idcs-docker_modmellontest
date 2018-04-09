#!/bin/bash

. settings.sh

docker rmi $IMGNAME

# only create the metadata if we don't have it already
if [ ! -e metadata/${IDCS_APPNAME}.xml ]; then
  if [ ! -e mellon_create_metadata.sh ]; then
    wget https://raw.githubusercontent.com/UNINETT/mod_auth_mellon/master/mellon_create_metadata.sh
  fi
  chmod u+x mellon_create_metadata.sh

  cd metadata
  ../mellon_create_metadata.sh ${IDCS_APPNAME} http://localhost:${HTTP_LISTEN_PORT}/mellon
  
  # echo "Before continuing you MUST edit the SP metadata!"
  # echo ""
fi

#
# Removing this in favor of allowing for transient
#
# grep -i NameIDFormat metadata/${IDCS_APPNAME}.xml
# if [ $? != 0 ]; then
#   echo "Add a NameIDFormat to your SAML SP metadata file metadata/${IDCS_APPNAME}.xml"
#   echo "For example add:"
#   echo "  <NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress</NameIDFormat>"
#   echo ""
#   echo "Remember that it must be within the <SPSSODescriptor></SPSSODescriptor> block"
#   echo ""
#   echo "Once you've done that run this script again."
#   exit
# fi

# and then get the IdP metadata
if [ ! -e metadata/idcs.xml ]; then
  which idcs > /dev/null
  if [ $? == 0 ]; then
    idcs saml metadata > metadata/idcs.xml
  fi

  if [ ! -e metadata/idcs.xml ]; then
    echo "Download the IDCS SAML metadata and put it in metadata/idcs.xml"
  fi
fi

xmllint metadata/idcs.xml > /dev/null
if [ $? != 0 ]; then
  echo "IDCS Metadata (metadata/idp.xml) does not appear to be well formatted XML."
  echo "Please check it."
  exit 1
fi

# Create the app with the CLI
idcs app delete -name="${IDCS_APPNAME}"

idcs app create -name="${IDCS_APPNAME}" \
  -template=CustomSAMLAppTemplateId \
  -isSAMLApp=true \
  -SAMLMetadataFile=metadata/IDCS_DockerSAMLTest.xml \
  -SAMLNameIdFormat=saml-transient \
  -SAMLSignatureHashAlgorithm=SHA-1 \
  -SAMLLogoutEnabled=true


docker build -t $IMGNAME .
#docker tag $IMGNAME $IMGNAME:1
