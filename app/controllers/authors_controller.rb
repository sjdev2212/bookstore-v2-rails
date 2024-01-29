class AuthorsController < ApplicationController
    def index 
        @authors  = Author.all
    end 

    def show  

        @author = Author.find_by_id(
            params[:id]
        )
    end 

    def new 
        @author  = Author.new
end

def create
    @author = Author.new(author_params)
  
    respond_to do |format|
      if @author.save
        format.html { redirect_to author_url(@author), notice: "Author was successfully created." }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
private
def author_params
    params.require(:author).permit(:name, :date_of_birth, :biography, :nationality, :author_image)
  end
end