# coding:utf-8
require 'bundler/setup'
require 'active_record'
require 'sinatra'
require 'erb'

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection('development')

class Record < ActiveRecord::Base
end

get '/search_easy' do
 @title = "フリーワード検索"
 erb :search_easy
end

post '/search_easy_result' do
 @title = "検索結果"
 @keyword = params["keyword"]
 @results = Record.where("title like ?", "%#{@keyword}%")
 erb :result_list
end

get '/search_details' do
 @title = "詳細検索"
 erb :search_details
end 

get '/add_info' do
 @title = "データ登録"
 erb :add_info
end

class Gmd < ActiveRecord::Base
end

get '/gmd' do
  @gmds = Gmd.all
  erb :add_gmd
end

post '/new_gmd' do
  gmd = Gmd.new
  gmd.gmd_smd_id = params[:gmd_smd_id]
  gmd.material_type = params[:material_type]
  gmd.unit = params[:unit]
  gmd.save
  redirect '/gmd'
end

delete '/del_gmd' do
  gmd = Gmd.find(params[:gmd_smd_id])
  gmd.destroy
  redirect '/gmd'
end


class Name < ActiveRecord::Base
end

get '/name' do
  @names = Name.all
  erb :add_name
end

post '/new_name' do
  name = Name.new
  name.creator_id = params[:creator_id]
  name.name = params[:name]
  name.name_hurigana = params[:name_hurigana]
  name.name_eng = params[:name_eng]
  name.date_birth = params[:date_birth]
  name.date_decease = params[:date_decease]
  name.save
  redirect '/name'
end

delete '/del_name' do
  name = Name.find(params[:creator_id])
  name.destroy
  redirect '/name'
end

class Language < ActiveRecord::Base
end

get '/lang' do
  @langs = Language.all
  erb :add_lang
end

post '/new_lang' do
  lang = Language.new
  lang.lang_cd = params[:lang_cd]
  lang.language = params[:language]
  lang.save
  redirect '/lang'
end

delete '/del_lang' do
  lang = Language.find(params[:lang_cd])
  lang.destroy
  redirect '/lang'
end

class Ufile < ActiveRecord::Base
end

get '/ufile' do
  @ufiles = Ufile.all
  erb :add_file
end

post '/new_ufile' do
  ufile = Ufile.new
  ufile.upfile_id = params[:upfile_id]
  ufile.upfile = params[:upfile]
  ufile.path = params[:path]
  ufile.save
  redirect '/ufile'
end

delete '/del_ufile' do
  ufile = Ufile.find(params[:upfile_id])
  ufile.destroy
  redirect '/ufile'
end
