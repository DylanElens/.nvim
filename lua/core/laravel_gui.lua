require("laravel").setup()
require("telescope").load_extension("laravel")
local resolver = require("laravel.environment.resolver")

resolver(false, false, "docker-compose")
