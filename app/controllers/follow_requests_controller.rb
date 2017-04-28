class FollowRequestsController < ApplicationController
  def index
    @follow_requests = FollowRequest.all

    render("follow_requests/index.html.erb")
  end

  def show
    @follow_request = FollowRequest.find(params[:id])

    render("follow_requests/show.html.erb")
  end

  def new
    @follow_request = FollowRequest.new

    render("follow_requests/new.html.erb")
  end

  def create
    @follow_request = FollowRequest.new

    @follow_request.sender_id = params[:sender_id]
    @follow_request.recipient_id = params[:recipient_id]

    save_status = @follow_request.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/follow_requests/new", "/create_follow_request"
        redirect_to("/follow_requests")
      else
        redirect_back(:fallback_location => "/", :notice => "Follow request created successfully.")
      end
    else
      render("follow_requests/new.html.erb")
    end
  end

  def edit
    @follow_request = FollowRequest.find(params[:id])

    render("follow_requests/edit.html.erb")
  end

  def update
    @follow_request = FollowRequest.find(params[:id])

    @follow_request.sender_id = params[:sender_id]
    @follow_request.recipient_id = params[:recipient_id]

    save_status = @follow_request.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/follow_requests/#{@follow_request.id}/edit", "/update_follow_request"
        redirect_to("/follow_requests/#{@follow_request.id}", :notice => "Follow request updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Follow request updated successfully.")
      end
    else
      render("follow_requests/edit.html.erb")
    end
  end

  def destroy
    @follow_request = FollowRequest.find(params[:id])

    @follow_request.destroy

    if URI(request.referer).path == "/follow_requests/#{@follow_request.id}"
      redirect_to("/", :notice => "Follow request deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Follow request deleted.")
    end
  end
end
