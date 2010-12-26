class PmsController < ApplicationController
  # GET /pms
  # GET /pms.xml
  def index
    @pms = Pm.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pms }
    end
  end

  # GET /pms/1
  # GET /pms/1.xml
  def show
    @pm = Pm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pm }
    end
  end

  # GET /pms/new
  # GET /pms/new.xml
  def new
    @pm = Pm.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pm }
    end
  end

  # GET /pms/1/edit
  def edit
    @pm = Pm.find(params[:id])
  end

  # POST /pms
  # POST /pms.xml
  def create
    @pm = Pm.new(params[:pm])

    respond_to do |format|
      if @pm.save
        format.html { redirect_to(@pm, :notice => 'Pm was successfully created.') }
        format.xml  { render :xml => @pm, :status => :created, :location => @pm }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pms/1
  # PUT /pms/1.xml
  def update
    @pm = Pm.find(params[:id])

    respond_to do |format|
      if @pm.update_attributes(params[:pm])
        format.html { redirect_to(@pm, :notice => 'Pm was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pms/1
  # DELETE /pms/1.xml
  def destroy
    @pm = Pm.find(params[:id])
    @pm.destroy

    respond_to do |format|
      format.html { redirect_to(pms_url) }
      format.xml  { head :ok }
    end
  end
end
