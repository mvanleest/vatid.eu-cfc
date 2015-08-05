component
	output = "false"
	hint = "I provide a gateway to the vatid.eu service."
	{


	function init(
		string myCountry="",
		string myVAT=""
		){

		variables.myCountry = arguments.myCountry.trim();
		variables.myVAT = arguments.myVAT.trim();
		// Return this object reference.
		return( this );
	}

	function checkVAT(
		required string country,
		required string vat,
		boolean useMyInfo=true
		){

		var httpreq = "";
		var result = "";

		if(arguments.useMyInfo EQ true AND variables.myCountry.len() EQ 2 AND variables.myVAT.len() GTE 6){
			httpreq = new Http(url="http://vatid.eu/check/#arguments.country.trim().uCase()#/#arguments.vat.trim()#/#variables.myCountry#/#variables.myVAT#",method="GET")
							.addParam(type="header", name="Accept", value="application/json");;
		} else{
			httpreq = new Http(url="http://vatid.eu/check/#arguments.country.trim().uCase()#/#arguments.vat.trim()#",method="GET")
							.addParam(type="header", name="Accept", value="application/json");;
		}

		result = httpreq.send().getPrefix();

		return deserializeJSON(result.fileContent);
	}


}
