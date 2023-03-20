class ReviewsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index 
        reviews = Review.all 
        render json: reviews, status: :ok 
    end 

    def show 
        review = find_review 
        if review 
            render json: review, status: :ok 
        else 
            render json: {error: "Review not found"}, status: :not_found 
        end
    end 

    def create 
        review = Review.create!(review_params)
        render json: review, status: :created 
    end 

    def update 
        review = find_review 
        spice.update(review_params)
        render json: review, status: :ok
    end 

    def destroy 
        review = find_review
        if review
        review.destroy 
        head :no_content 
        else
            render json: { error: "Review not found" }, status: :not_found 
        end
    end

    private 

    def find_review
        Review.find_by(id: params[:id]) 
    end

    def review_params 
        params.permit(:comment, :rating)
    end
    
    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end


end