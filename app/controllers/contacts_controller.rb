class ContactsController < InheritedResources::Base

  def new
  	@contact = Contact.new
  end

  def create
  	  name = params[:name]
  	  email = params[:email]
  	  phone = params[:phone]
  	  message = params[:message]

	  @contact = Contact.new(contact_params)

	  respond_to do |format|
	    if @contact.save

	      # Sends email to contact when contact is created.
	      ExampleMailer.sample_email(@contact).deliver

	      format.html { redirect_to @contact, notice: 'contact was successfully created.' }
	      format.json { render :show, status: :created, location: @contact }
	    else
	      format.html { render :new }
	      format.json { render json: @contact.errors, status: :unprocessable_entity }
	    end
	  end
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :email, :phone, :message)
    end
end

