class ParadigmsController < ApplicationController
  
  before_filter :require_user
  before_filter :get_paradigm, :only => [:show, :edit, :update]
  
  def index    
    @paradigms = Paradigm.all
    @columns = %w(human_singular human_plural experiment_type)
    respond_to do |format|
      format.html
      format.csv { render :content_type => "text/csv", :layout => false }
    end
  end
  
  def show
  end
  
  def new
    @paradigm = Paradigm.new
  end
  
  def create
    @paradigm = Paradigm.build(params[:paradigm])
    if @paradigm.save
      flash[:notice] = "Paradigm created sucessfully."
      redirect_to @paradigm
    else
      flash[:notice] = "Try again."
      render :new
      end
  end
  
  def edit
  end
  
  def update
    if @paradigm.update_attributes(params[:paradigm])
      flash[:notice] = "Paradigm updated sucessfully."
      redirect_to @paradigm
    else
      flash[:notice] = "Try again."
      render :edit
    end
  end
  
  private 
  
  def get_paradigm
    @paradigm = Paradigm.find(params[:id])
  end
  
end
