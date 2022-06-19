# frozen_string_literal: true

class UrlsController < ApplicationController
  before_action :url_params, only: [:create]
  def index
    # recent 10 short urls
    @url = Url.new()
    # @urls = [
    #   Url.new(short_url: 'ABCDE', original_url: 'http://google.com', created_at: Time.now),
    #   Url.new(short_url: 'ABCDG', original_url: 'http://facebook.com', created_at: Time.now),
    #   Url.new(short_url: 'ABCDF', original_url: 'http://yahoo.com', created_at: Time.now)
    # ]
    @urls = Url.order(created_at: :desc).limit(1000)
  end

  def create
    puts url_params
    @url = Url.new(url_params)

    if @url.save
      redirect_to '/'
    else
      #todo show error
      raise 'todo show error'
    end
  end

  def show
    @url = Url.new(short_url: 'ABCDE', original_url: 'http://google.com', created_at: Time.now)
    # implement queries
    @daily_clicks = [
      ['1', 13],
      ['2', 2],
      ['3', 1],
      ['4', 7],
      ['5', 20],
      ['6', 18],
      ['7', 10],
      ['8', 20],
      ['9', 15],
      ['10', 5]
    ]
    @browsers_clicks = [
      ['IE', 13],
      ['Firefox', 22],
      ['Chrome', 17],
      ['Safari', 7]
    ]
    @platform_clicks = [
      ['Windows', 13],
      ['macOS', 22],
      ['Ubuntu', 17],
      ['Other', 7]
    ]
  end

  def visit
    @url = Url.where(short_url:  params[:short_url]).first
    @url.clicks_count+=1
    if @url.save && @url.clicks.create!(browser: browser.name,platform:browser.platform.name)
      redirect_to @url.original_url
    else
      raise 'todo show error'
    end
  end

  private
  def url_params
    params.require(:url).permit(:original_url)
  end

end
