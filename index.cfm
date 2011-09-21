<!--- get the available templates from the template folder --->

<h1>ColdDoc</h1>

<p><a href="http://colddoc.riaforge.org/">ColdDoc</a> is a tool that has been built to generate documentation based on ColdFusion Component Meta Data.</p>

<p>This plugin will enables ColdDoc to generate documentation for your Wheels application, follow the instructions below.</p>

<p>REQUIRED: Drop colddoc inside the webroot folder in your Wheels application.</p>

<h2>Instructions</h2>

<ul>
	<li>Select the type of ColdDoc to perform.</li>
	<li>Select the strategy of ColdDoc to perform.</li>
	<li>Click the "Generate" submit button.</li>
</ul>

<h2>Generate form</h2>
<cfparam name="params.path" default="/miscellaneous/docs">
<cfparam name="params.title" default="API Docs">
<cfif isDefined("params.typeOfColdDoc") and isDefined("params.strategyOfColdDoc")>
	<cfoutput>
	<cfsavecontent variable="href">
	#params.path#/#params.strategyOfColdDoc#/<cfif params.strategyOfColdDoc EQ 'html'>index.html<cfelse>colddoc.uml</cfif>
	</cfsavecontent>

    <p><tt>#generateColdDoc(type=params.typeOfColdDoc, strategy=params.strategyOfColdDoc, title=params.title, path=params.path)#</tt></p>

    <hr/>
    <p><a href="#href#" target="_blank">Documentation Generated: (#params.path#)</a></p>
    </cfoutput>
    <hr/>
<cfelse>

	<p><tt>Example: If your table is named "users", insert "user" in the form field below.</tt></p>

</cfif>

<!--- Form --->
<cfform action="#CGI.script_name & '?' & CGI.query_string#">

	<cfoutput>
		<p><label for="path">Title</label> <br>
		<input type="text" value="#params.title#" size="45">
		</p>

		<p><label for="path">Path (relative to webroot)</label> <br>
		<input type="text" value="#params.path#" size="45">
		</p>
	</cfoutput>

	<p><label for="strategyOfColdDoc">Strategy</label> <br>
	<cfselect name="strategyOfColdDoc">
		<option value="html" selected="selected">HTML</option>
		<option value="uml">UML</option>
	</cfselect>
	</p>

	<p><label for="typeOfColdDoc">Type</label> <br>
	<cfselect name="typeOfColdDoc">
		<option value="everything" selected="selected">Model and Controller</option>
		<option value="controller">Controller</option>
		<option value="model">Model</option>
	</cfselect>
	</p>

	<p><cfinput type="submit" name="btnSubmit" value="Generate"></p>

</cfform>

<a href="<cfoutput>#cgi.http_referer#</cfoutput>"><<< Go Back</a>