require "open3"

class CompilersController < ApplicationController

  def rbSourceInput
    @compiler = Compiler.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @compiler }
    end
  end

  def index
    rbSourceInput
  end

  def show
    rbSourceInput
  end

  def new
    rbSourceInput
  end

  def edit
    rbSourceInput
  end

  #Directry All Delete
  def deleteall(delthem)
    if FileTest.directory?(delthem) then
      Dir.foreach( delthem ) do |file|
        next if /^\.+$/ =~ file
        deleteall( delthem.sub(/\/+$/,"") + "/" + file )
      end
      Dir.rmdir(delthem) rescue ""
    else
      File.delete(delthem)
    end
  end

  #Send mrb file
  def send_mrb( pathrbname, opt )
    if(opt.include?("-h")==true)then
      o, e, s = Open3.capture3("mrbc -h >&2")
      redirect_to @compiler, notice: e.to_s + ' ' + s.to_s

      @compiler.destroy
      return
    end

    if( pathrbname=='' )then
      @compiler.destroy
      render action: "new"
      return
    end

    rbfile = File.basename(pathrbname)
    mrbfile = File.basename(pathrbname, ".rb") + ".mrb"
    fullpath = Rails.root.to_s + "/public" + File.dirname(pathrbname) + "/" 
    o, e, s = Open3.capture3("cd " + fullpath + "; mrbc " + opt + " -o" + mrbfile + " " + rbfile + " >&2")
    if( e==''  ) then
      mrb_data = File.binread(fullpath + mrbfile)
      send_data(mrb_data,
        filename: mrbfile,
        type: "application/octet-stream",
        disposition: "inline")
    else
      redirect_to @compiler, notice: e.to_s + ' ' + s.to_s
    end

    @compiler.destroy
    deleteall( fullpath )
  end

  def create
    @compiler = Compiler.new(params[:compiler])

    respond_to do |format|
      if @compiler.save
        format.html { send_mrb( @compiler.rb.to_s , @compiler.options.to_s ) }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    rbSourceInput
  end

  def destroy
    @compiler = Compiler.find(params[:id])
    @compiler.destroy

    respond_to do |format|
      format.html { redirect_to compilers_url }
      format.json { head :no_content }
    end
  end
end
