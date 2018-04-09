<html lang="en">
<HEAD>
  <TITLE>Protected page</TITLE>
  <link rel="stylesheet" href="/style.css">
</HEAD>
<BODY>

<h1>Welcome to the protected directory.</h1>

<HR width="50%"/>
<P/>
<table>

<tr>
  <th align=right>Remote user</th>
  <td><? print $_SERVER['REMOTE_USER']?></td>
</tr>

<tr>
  <th align=right>NAME ID</th>
  <td><? print $_SERVER['MELLON_NAME_ID']?></td>
</tr>

<tr>
  <th align=right>IDCS Tenant</th>
  <td><? print $_SERVER['MELLON_oracle:cloud:identity:domain']?></td>
</tr>

<? if ( strlen( $_SERVER["MELLON_SAML_RESPONSE"] ) > 0 ) { ?>
<tr>
  <th align=right>SAML Response</th>
  <td><PRE><?PHP echo htmlentities(base64_decode($_SERVER["MELLON_SAML_RESPONSE"])); ?></PRE></td>
</tr>

<? } ?>

</BODY>
</HTML>
