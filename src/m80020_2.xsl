<?xml version="1.0" encoding="windows-1251"?> 

<xsl:stylesheet version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/message">
    <html>
      INSERT INTO tbl80020Message (class, version, number) VALUES( '<xsl:value-of select="@class" />', '<xsl:value-of select="@version" />' , '<xsl:value-of select="@number" />' )
      <xsl:apply-templates />
    </html>
  </xsl:template>

  <xsl:template match="datetime">
    INSERT INTO tbl80020DateTime (day, timestamp, daylightsavingtime) VALUES('<xsl:value-of select="day"/>' ,'<xsl:value-of select="timestamp"/>' , '<xsl:value-of select="daylightsavingtime"/>' )
  </xsl:template>

  <xsl:template match="sender/name">
  </xsl:template>

  <xsl:template match="sender/inn">
  </xsl:template>

  <xsl:template match="sender">
    INSERT INTO tbl80020Sender (inn, name) VALUES('<xsl:value-of select="inn"/>' , '<xsl:value-of select="name"/>' )
  </xsl:template>

  <xsl:template match="comment">
    INSERT INTO tbl80020Comment (comment) VALUES('<xsl:value-of select="."/>' )
  </xsl:template>

  <xsl:template match="area">
    INSERT INTO tbl80020Area (inn, name, timezone) VALUES('<xsl:value-of select="inn"/>', '<xsl:value-of select="name"/>', '<xsl:value-of select="@timezone"/>')
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="measuringpoint">
    INSERT INTO tbl80020MeasuringPoint (Name, Code) VALUES('<xsl:value-of select="@name"/>', '<xsl:value-of select="@code"/>' )
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="accountpoint">
    INSERT INTO tbl80020AccountPoint (Name, Code) VALUES('<xsl:value-of select="@name"/>', '<xsl:value-of select="@code"/>' )
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="deliverypoint">
    INSERT INTO tbl80020DeliveryPoint (Name, Code) VALUES('<xsl:value-of select="@name"/>', '<xsl:value-of select="@code"/>' )
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="measuringchannel" >
    INSERT INTO tbl80020MeasuringChannel ( code, desc ) VALUE ( '<xsl:value-of select="@code"/>' , '<xsl:value-of select="@desc"/>' )
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="deliverygroup" >
    INSERT INTO tbl80020DeliveryGroup ( code, name ) VALUE ( '<xsl:value-of select="@code"/>', '<xsl:value-of select="@name"/>' )
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="peretok" >
    INSERT INTO tbl80020Peretok ( name, codefrom, codeto ) VALUE ( '<xsl:value-of select="@name"/>' , '<xsl:value-of select="@codefrom"/>', '<xsl:value-of select="@codeto"/>' )
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="period" >
    INSERT INTO tbl80020Value ( start, end, summer, value ) VALUE ( '<xsl:value-of select="@start"/>' , '<xsl:value-of select="@end"/>', '<xsl:value-of select="@summer"/>', '<xsl:value-of select="value"/>')
  </xsl:template>
  
</xsl:stylesheet>