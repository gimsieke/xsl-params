# xsl-params
Extract XSLT stylesheet params, in response to [Graydon’s request](https://sourceforge.net/p/saxon/mailman/message/37386191/)

Sample invocation:

```bash
saxon -it:test -xsl:params-function.xsl '!indent=yes'
```

Output:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<params>
   <param overridden="file:/C:/cygwin/home/gerrit/XML/saxon-support/2021-11-17_graydonish@gmail.com/xsl-params/params.xsl"
          origin="file:/C:/cygwin/home/gerrit/XML/saxon-support/2021-11-17_graydonish@gmail.com/xsl-params/params-function.xsl"
          name="foo"
          select="'baz'"
          as="xs:string"/>
</params>
```
