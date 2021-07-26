// Contains generic useful javascript functions

var string_helpers = {
	methods: {
		toTitleCase(str) {
			return str.replace(/[_-]+/g, ' ').replace(
		    /\w\S*/g,
		    function(txt) {
		      return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
		    }
		  )
		},
		toSnakeCase(str) {
			return str.replace(/([a-z ])([A-Z])/g, "$1 $2" )
				.replace(/ +/g, "_").toLowerCase()
		}
	}
}
export default string_helpers