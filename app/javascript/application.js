// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import "@hotwired/turbo-rails";
import "controllers";

Rails.start();
Turbolinks.start();

