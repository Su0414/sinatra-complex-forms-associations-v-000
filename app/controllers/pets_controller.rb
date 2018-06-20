class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do

    puts params
    @pet = Pet.create(params[:pet])
    # if !params["owner"]["name"].empty?
    #
    # end
    @pet.save



    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owner = Owner.find_by_id(@pet.owner_id)
    erb :'/pets/show'
  end

  post '/pets/:id' do
    puts params

    @pet = Pet.find(params[:id])
      @pet.update(params["pet"])
      if !params["owner"]["name"].empty?
        @pet.owners << Owner.create(name: params["owner"]["name"])
      end
    redirect to "pets/#{@pet.id}"
  end
end
