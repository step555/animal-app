class AdoptionsController < ApplicationController
    helper_method :approve

    def index
        @adoptions = Adoption.all
        @sorted_status = @adoptions.order(:status)
        @sorted_dogs = @adoptions.order(:animal_id)
        # @categories = Category.order(:name)

    end

    def new
        @adoption = Adoption.new
        @animal = Animal.find(params[:animal_id])
    end

    def create
       
        @adoption = Adoption.new(user_id: params[:adoption][:user_id], animal_id: params[:animal_id], reason: params[:adoption][:reason])
        @animal = Animal.find(params[:animal_id])

        if @adoption.valid?
            @adoption.save 
            redirect_to animal_adoption_path(@animal, @adoption)
        else
            render :new
       end
    end

    def show
        @adoption = Adoption.find(params[:id])
    end
    
    def edit
        @adoption = Adoption.find(params[:id])
    end
  
    def update
        @adoption.update(user_id: params[:adoption][:user_id], animal_id: params[:animal_id], reason: params[:adoption][:reason])
        @animal = Animal.find(params[:animal_id])
        redirect_to animal_adoption_path(@animal, @adoption)
    end

    def destroy
        @adoption = Adoption.find(params[:id])
        @adoption.destroy 
        redirect_to shelters_path
    end

    def approve
        @adoption = Adoption.find(params[:id])
        @adoption.status = params[:adoption][:status]
        @adoption.save
        redirect_to adoptions_path
    end


    
end
