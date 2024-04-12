require('neorg').setup {
	load = {
		["core.defaults"] = {},	-- Tells neorg to load the module called core.defaults with no extra data
		["core.concealer"] = {} -- Since this module isn't part of core.defaults, we can include it ourselves, like so
	}
}
