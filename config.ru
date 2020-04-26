# This file is used by Rack-based servers to start the application.
require ::File.expand_path('../api/app', __FILE__)
run App.freeze.app
