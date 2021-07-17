// Contains generic useful javascript functions

var string_helpers = {
	methods: {
		toTitleCase(str) {
			return str.replace(
		    /\w\S*/g,
		    function(txt) {
		      return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
		    }
		  )
		}
	}
}
export default string_helpers