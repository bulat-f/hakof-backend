# frozen_string_literal: true


class CommentsController < ApplicationController
  before_action :authorize_request
  before_action :find_user, except: %i[index create]

  # GET /comments
  def index
    @comments = current_user.comments
    json = CommentBlueprint.render @comments
    render json: json, status: :ok
  end

  # POST /comments
  def create
    @comment = current_user.comments.build comment_params
    if @comment.save
      json = CommentBlueprint.render @comment
      render json: json, status: :created
    else
      render json: { errors: @comment.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /comments/{id}
  def update
    if @comment.update(user_params)
      json = UserBlueprint.render @user, view: :extended
      render json: json, status: :ok
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /comments/{id}
  def destroy
    @user.destroy
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Comment not found' }, status: :not_found
  end

  def comment_params
    params.permit(:article_id, :reply_to_id, :text)
  end
end
