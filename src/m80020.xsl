 

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/message">

      <xsl:if test="(/message/@class = 80020) and (/message/@version = 2)">

        INSERT INTO tbl80020Header ([number], [day], [timestamp], [daylightsavingtime], [inn], [name], [comment])
        VALUES(
        '<xsl:value-of select="/message/@number" />',
        '<xsl:value-of select="/message/datetime/day" />' ,
        '<xsl:value-of select="/message/datetime/timestamp" />',
        '<xsl:value-of select="/message/datetime/daylightsavingtime" />',
        '<xsl:value-of select="/message/sender/inn" />',
        '<xsl:value-of select="/message/sender/name" />' ,
        '<xsl:value-of select="/message/comment" />'
        );

        <xsl:for-each select="area">
          INSERT INTO tbl80020Area ([inn], [name], [timezone], [headerINN], [headerNumber])
          VALUES(
          '<xsl:value-of select="inn"/>',
          '<xsl:value-of select="name"/>',
          '<xsl:value-of select="@timezone"/>',
          '<xsl:value-of select="/message/@number"/>',
          '<xsl:value-of select="/message/sender/inn"/>'
          );

          <xsl:apply-templates select="measuringpoint">
          	<xsl:with-param name="headerINN"><xsl:value-of select="/message/sender/inn" /></xsl:with-param>
          	<xsl:with-param name="headerNumber"><xsl:value-of select="/message/@number" /></xsl:with-param>
          	<xsl:with-param name="areaINN"><xsl:value-of select="inn" /></xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="accountpoint">
           	<xsl:with-param name="headerINN"><xsl:value-of select="/message/sender/inn" /></xsl:with-param>
          	<xsl:with-param name="headerNumber"><xsl:value-of select="/message/@number" /></xsl:with-param>
          	<xsl:with-param name="areaINN"><xsl:value-of select="inn" /></xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="deliverypoint">
           	<xsl:with-param name="headerINN"><xsl:value-of select="/message/sender/inn" /></xsl:with-param>
          	<xsl:with-param name="headerNumber"><xsl:value-of select="/message/@number" /></xsl:with-param>
          	<xsl:with-param name="areaINN"><xsl:value-of select="inn" /></xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="deliverygroup">
           	<xsl:with-param name="headerINN"><xsl:value-of select="/message/sender/inn" /></xsl:with-param>
          	<xsl:with-param name="headerNumber"><xsl:value-of select="/message/@number" /></xsl:with-param>
          	<xsl:with-param name="areaINN"><xsl:value-of select="inn" /></xsl:with-param>
          </xsl:apply-templates>
          <xsl:apply-templates select="peretok">
           	<xsl:with-param name="headerINN"><xsl:value-of select="/message/sender/inn" /></xsl:with-param>
          	<xsl:with-param name="headerNumber"><xsl:value-of select="/message/@number" /></xsl:with-param>
          	<xsl:with-param name="areaINN"><xsl:value-of select="inn" /></xsl:with-param>
          </xsl:apply-templates>

       </xsl:for-each>

      </xsl:if>

  </xsl:template>

  <xsl:template match="measuringpoint">
    <xsl:param name="headerINN"/>
    <xsl:param name="headerNumber"/>
    <xsl:param name="areaINN"/>
    INSERT INTO tbl80020MeasuringPoint ([Name], [Code], [areaINN], [headerINN], [headerNumber]) VALUES('<xsl:value-of select="@name"/>', '<xsl:value-of select="@code"/>', '<xsl:value-of select="$areaINN"/>', '<xsl:value-of select="$headerINN"/>', '<xsl:value-of select="$headerNumber"/>');
    <xsl:apply-templates select="measuringchannel">
    	<xsl:with-param name="headerINN"><xsl:value-of select="$headerINN" /></xsl:with-param>
        <xsl:with-param name="headerNumber"><xsl:value-of select="$headerNumber" /></xsl:with-param>
        <xsl:with-param name="areaINN"><xsl:value-of select="$areaINN" /></xsl:with-param>
        <xsl:with-param name="Code1"><xsl:value-of select="@code" /></xsl:with-param>
        <xsl:with-param name="Code2"></xsl:with-param>        
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="accountpoint">
    <xsl:param name="headerINN"/>
    <xsl:param name="headerNumber"/>
    <xsl:param name="areaINN"/>
    INSERT INTO tbl80020AccountPoint ([Name], [Code], [areaINN], [headerINN], [headerNumber]) VALUES('<xsl:value-of select="@name"/>', '<xsl:value-of select="@code"/>', '<xsl:value-of select="$areaINN"/>', '<xsl:value-of select="$headerINN"/>', '<xsl:value-of select="$headerNumber"/>' );
    <xsl:apply-templates select="measuringchannel">
    	<xsl:with-param name="headerINN"><xsl:value-of select="$headerINN" /></xsl:with-param>
        <xsl:with-param name="headerNumber"><xsl:value-of select="$headerNumber" /></xsl:with-param>
        <xsl:with-param name="areaINN"><xsl:value-of select="$areaINN" /></xsl:with-param>
        <xsl:with-param name="Code1"><xsl:value-of select="@code" /></xsl:with-param>
        <xsl:with-param name="Code2"></xsl:with-param>        
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="deliverypoint">
    <xsl:param name="headerINN"/>
    <xsl:param name="headerNumber"/>
    <xsl:param name="areaINN"/>
    INSERT INTO tbl80020DeliveryPoint ([Name], [Code], [areaINN], [headerINN], [headerNumber]) VALUES('<xsl:value-of select="@name"/>', '<xsl:value-of select="@code"/>', '<xsl:value-of select="$areaINN"/>', '<xsl:value-of select="$headerINN"/>', '<xsl:value-of select="$headerNumber"/>' );
    <xsl:apply-templates select="measuringchannel">
    	<xsl:with-param name="headerINN"><xsl:value-of select="$headerINN" /></xsl:with-param>
        <xsl:with-param name="headerNumber"><xsl:value-of select="$headerNumber" /></xsl:with-param>
        <xsl:with-param name="areaINN"><xsl:value-of select="$areaINN" /></xsl:with-param>
        <xsl:with-param name="Code1"><xsl:value-of select="@code" /></xsl:with-param>
        <xsl:with-param name="Code2"></xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="measuringchannel" >
    <xsl:param name="headerINN"/>
    <xsl:param name="headerNumber"/>
    <xsl:param name="areaINN"/>
    <xsl:param name="Code1"/>
    INSERT INTO tbl80020MeasuringChannel ( [code], [desc], [pointCode], [areaINN], [headerINN], [headerNumber] ) VALUES ( '<xsl:value-of select="@code"/>', '<xsl:value-of select="@desc"/>', '<xsl:value-of select="$Code1"/>' , '<xsl:value-of select="$areaINN"/>', '<xsl:value-of select="$headerINN"/>', '<xsl:value-of select="$headerNumber"/>' );
    <xsl:apply-templates select="period">
    	<xsl:with-param name="headerINN"><xsl:value-of select="$headerINN" /></xsl:with-param>
        <xsl:with-param name="headerNumber"><xsl:value-of select="$headerNumber" /></xsl:with-param>
        <xsl:with-param name="areaINN"><xsl:value-of select="$areaINN" /></xsl:with-param>
        <xsl:with-param name="Code1"><xsl:value-of select="$Code1" /></xsl:with-param>
        <xsl:with-param name="Code2"><xsl:value-of select="@code" /></xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="deliverygroup" >
    <xsl:param name="headerINN"/>
    <xsl:param name="headerNumber"/>
    <xsl:param name="areaINN"/>
    INSERT INTO tbl80020DeliveryGroup ( [code], [name], [areaINN], [headerINN], [headerNumber] ) VALUES ( '<xsl:value-of select="@code"/>', '<xsl:value-of select="@name"/>', '<xsl:value-of select="$areaINN"/>', '<xsl:value-of select="$headerINN"/>', '<xsl:value-of select="$headerNumber"/>' );
    <xsl:apply-templates select="period">
    	<xsl:with-param name="headerINN"><xsl:value-of select="$headerINN" /></xsl:with-param>
        <xsl:with-param name="headerNumber"><xsl:value-of select="$headerNumber" /></xsl:with-param>
        <xsl:with-param name="areaINN"><xsl:value-of select="$areaINN" /></xsl:with-param>
        <xsl:with-param name="Code1"><xsl:value-of select="@code" /></xsl:with-param>
        <xsl:with-param name="Code2"></xsl:with-param>        
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="peretok" >
    <xsl:param name="headerINN"/>
    <xsl:param name="headerNumber"/>
    <xsl:param name="areaINN"/>
    INSERT INTO tbl80020Peretok ( [name], [codefrom], [codeto], [areaINN], [headerINN], [headerNumber] ) VALUES ( '<xsl:value-of select="@name"/>', '<xsl:value-of select="@codefrom"/>', '<xsl:value-of select="@codeto"/>', '<xsl:value-of select="$areaINN"/>', '<xsl:value-of select="$headerINN"/>', '<xsl:value-of select="$headerNumber"/>' );
    <xsl:apply-templates select="period">
    	<xsl:with-param name="headerINN"><xsl:value-of select="$headerINN" /></xsl:with-param>
        <xsl:with-param name="headerNumber"><xsl:value-of select="$headerNumber" /></xsl:with-param>
        <xsl:with-param name="areaINN"><xsl:value-of select="$areaINN" /></xsl:with-param>
        <xsl:with-param name="Code1"><xsl:value-of select="@codefrom" /></xsl:with-param>
        <xsl:with-param name="Code2"><xsl:value-of select="@codeto" /></xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="period" >
    <xsl:param name="headerINN"/>
    <xsl:param name="headerNumber"/>
    <xsl:param name="areaINN"/>
    <xsl:param name="Code1"/>
    <xsl:param name="Code2"/>    
    INSERT INTO tbl80020Value ( [start], [end], [summer], [value], [status], [errofmeasuring], [exstendedstatus], [param1], [param2], [param3], [Code1], [Code2], [areaINN], [headerINN], [headerNumber]) VALUES ( '<xsl:value-of select="@start"/>', '<xsl:value-of select="@end"/>', '<xsl:value-of select="@summer"/>', '<xsl:value-of select="value"/>', '<xsl:value-of select="@status"/>', '<xsl:value-of select="@errofmeasuring"/>', '<xsl:value-of select="@exstendedstatus"/>', '<xsl:value-of select="@param1"/>', '<xsl:value-of select="@param2"/>', '<xsl:value-of select="@param3"/>', '<xsl:value-of select="$Code1"/>', '<xsl:value-of select="$Code2"/>', '<xsl:value-of select="$areaINN"/>', '<xsl:value-of select="$headerINN"/>', '<xsl:value-of select="$headerNumber"/>' );
  </xsl:template>

  <xsl:template match="testonly" >
  </xsl:template>

  <xsl:template match="comment" >
  </xsl:template>

</xsl:stylesheet>

