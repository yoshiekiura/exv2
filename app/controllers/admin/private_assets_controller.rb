class PrivateAssetsController < Admin::BaseController
	def download
      if ["png", "jpg", "jpeg", "bmp", "gif"].include? params[:extension] and ["id_document_file", "id_bill_file"].include? params[:filetype]
      	send_file "#{Rails.root}/uploads/asset/#{params[:filetype]}/file/#{params[:id]}/#{params[:filename]}.#{params[:extension]}", type: "image/#{params[:extension]}", disposition: 'inline'
      end
    end
end

