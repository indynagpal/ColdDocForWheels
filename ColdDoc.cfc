<cfcomponent output="false" mixin="controller" environment="design,development">

	<cffunction name="init">
		<cfset this.version = "1.0,1.0.1,1.0.2,1.1">
		<cfreturn this>
	</cffunction>

	<cffunction name="generateColdDoc" access="public" returnType="string" hint="Creates a Model a Controller and the Views for the name of the argument passed" output="false">
		<cfargument name="type" type="string" required="true" default="everything" hint="Type of generation to execute, values are: everything, controller, model">
		<cfargument name="strategy" type="string" required="true" hint="Name of the object to ColdDoc">
		<cfargument name="path" type="string" required="true" hint="Path where to generate the doc">
		<cfargument name="title" type="string" required="true" hint="Title to generate">

		<cfset var loc = {}>

		<!--- Setup the information for the user --->
		<cfset loc.message = "">

		<cfset loc.colddoc = createObject("component", "ColdDoc.ColdDoc").init() />
		<cfif (arguments.strategy IS "html")>
			<cfset loc.strategy = createObject("component", "colddoc.strategy.api.HTMLAPIStrategy").init(expandPath(".#arguments.path#/#arguments.strategy#"), arguments.title) />
		<cfelseif (arguments.strategy IS "uml")>
			<cfset loc.strategy = createObject("component", "colddoc.strategy.uml2tools.XMIStrategy").init(expandPath(".#arguments.path#/colddoc.uml")) />
		</cfif>

		<cfset loc.colddoc.setStrategy(loc.strategy) />
		<cfif (arguments.type IS "everything")>
		<cfset paths = [
			    { inputDir = expandPath("/models")
			      ,inputMapping = "models"
			    }
			    ,{
			      inputDir = expandPath("/controllers")
			      ,inputMapping = "controllers"
			    }

			] />
		<cfelseif (arguments.type IS "controller")>
			<cfset paths = [
			    {
			      inputDir = expandPath("/controllers")
			      ,inputMapping = "controllers"
			    }

			] />

		<cfelseif (arguments.type IS "model")>
		<cfset paths = [
		    { inputDir = expandPath("/models")
		      ,inputMapping = "models"
		    }
			] />

		</cfif>
		<cfset loc.colddoc.generate(paths) />

		<!--- Check which type of ColdDoc to execute --->
		<cfif arguments.type IS "everything">
			<!--- Create the model --->
		    <cfset loc.message = loc.message & "models #arguments.strategy# documentation created.<br/>">
			<!--- Create the controller --->
		    <cfset loc.message = loc.message & "controllers #arguments.strategy# documentation created.<br/>">
		<cfelseif arguments.type IS "model">
			<!--- Create the model --->
		    <cfset loc.message = loc.message & "models #arguments.strategy# documentation created.<br/>">
		<cfelseif arguments.type IS "controller">
		    <!--- Create the controller --->
		   <cfset loc.message = loc.message & "controllers #arguments.strategy# documentation created.<br/>">
	    </cfif>

		<cfreturn loc.message>
	</cffunction>

</cfcomponent>