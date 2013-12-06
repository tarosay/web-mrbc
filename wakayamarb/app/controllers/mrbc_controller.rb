class MrbcController < ApplicationController
  def mrbc
    @compiler = Compiler.new
  end
end
