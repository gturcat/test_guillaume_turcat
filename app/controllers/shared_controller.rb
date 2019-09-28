class SharedController < ApplicationController
  def header
    skip_authorization
  end
end
