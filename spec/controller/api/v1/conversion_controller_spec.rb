describe Api::V1::ConversionController, type: :controller do
  describe 'POST #create' do
    before do
      post :create, params: params, format: :json
    end

    context 'when there is no params' do
      let(:params) { }

      it 'responses with 400' do
        expect(response).to have_http_status(:bad_request)
      end
      it 'responses with error message' do
        expect(JSON.parse(response.body)['errors'].first['message']).to eq 'There was no data at all'
      end
    end

    context 'when params is invalid' do
      let(:params) { {name: 'demo-file', data: 'data:document/pdf;base64, aW52YWxpZCBmaWxlCg==', target: 'asd'} }

      it 'responses with 415' do
        expect(response).to have_http_status(:unsupported_media_type)
      end

      it 'responses with error message' do
        expect(JSON.parse(response.body)['errors'].first['message']).to include "There was no valid target format"
      end
    end

    context 'when file is invalid' do
      let(:params) { {name: 'demo-file', data: 'data:document/pdf;base64, aW52YWxpZCBmaWxlCg==', target: 'obj'} }

      it 'responses with 415' do
        expect(response).to have_http_status(:unsupported_media_type)
      end

      it 'responses with error message' do
        expect(JSON.parse(response.body)['errors'].first['message']).to eq 'There was no valid data file'
      end
    end

    context 'when file is valid' do
      let(:params) { {name: 'demo-file', data: 'data:document/shapr;base64, aW52YWxpZCBmaWxlCg==', target: 'obj'} }

      it 'responses with 200' do
        expect(response).to have_http_status(:success)
      end

      it 'responses without error message' do
        expect(JSON.parse(response.body)['errors']).to be_empty
      end

      it 'responses with uuid' do
        expect(JSON.parse(response.body)['uuid']).to match(/[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}/)
      end
    end
  end
end
