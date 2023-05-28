<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">	
	 <project default="getcents" basedir="." name="getcents">
      
       <description>		 
         Autogenerated Ant build file that downloads needed cents for the project.
       </description>
      	 
	   <target name="getcents">
	     <xsl:attribute name="depends">
	       <xsl:for-each select = "properties/centipede/tools/cents/*">
	         <xsl:value-of select="name()"/>-present,
           </xsl:for-each>
	       <xsl:for-each select = "properties/centipede/tools/cents/*">
	         <xsl:value-of select="name()"/>-target,
           </xsl:for-each>dummy-target
        </xsl:attribute> 
       </target>	   

       <xsl:apply-templates/>
       
	   <target name="dummy-target">
	     <echo message="cents fetch finished"/>
       </target> 
              
     </project>  
	</xsl:template>
	  	

	<xsl:template match="properties">	
	
	<xsl:variable name = "repository" select = "centipede/tools/cents/./@repository" />	 
      
      <xsl:for-each select = "centipede/tools/cents/*">
       
	   <target>
	      <xsl:attribute name="name"><xsl:value-of select="name()"/>-target</xsl:attribute>
	      <xsl:attribute name="unless"><xsl:value-of select="name()"/>.present</xsl:attribute>
	      <xsl:attribute name="depends"><xsl:value-of select="name()"/>-present</xsl:attribute> 
	      	      
        <antipede-jjar>
         
         <xsl:attribute name="package"><xsl:value-of select="name()"/>.cent</xsl:attribute> 
         <xsl:attribute name="repository"><xsl:value-of select="$repository"/></xsl:attribute>   
         <xsl:attribute name="localrepository">${cents.dir}</xsl:attribute>    
         <xsl:attribute name="pathrefid">dummy.classpath</xsl:attribute>
         <!--            
         <xsl:attribute name="version"></xsl:attribute> 
         <xsl:attribute name="pathrefid"></xsl:attribute> 
         <xsl:attribute name="classpath"></xsl:attribute> 
         <xsl:attribute name="onlyDependencies"></xsl:attribute> 
         <xsl:attribute name="verifyignore"></xsl:attribute> -->
      
        </antipede-jjar>
       </target>       
      </xsl:for-each>

      <xsl:for-each select = "centipede/tools/cents/*">
       
	   <target>
	      <xsl:attribute name="name"><xsl:value-of select="name()"/>-present</xsl:attribute>
	      
          <condition>
	        <xsl:attribute name="property"><xsl:value-of select="name()"/>.present</xsl:attribute>          
            <or>
             <available>
              <xsl:attribute name="file">${cents.dir}/<xsl:value-of select="name()"/>.cent.jar</xsl:attribute>          
             </available>
             <available type="dir">
              <xsl:attribute name="file">${cents.dir}/<xsl:value-of select="name()"/>.cent</xsl:attribute>          
            </available>
           </or>
          </condition>

          <echo><xsl:value-of select="name()"/> cent is present: ${<xsl:value-of select="name()"/>.present}</echo> 
 
       </target>       
      </xsl:for-each>
            	  
	</xsl:template>
		
</xsl:stylesheet>