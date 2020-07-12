describe Api::V1::ConversionController, type: :controller do
  describe 'POST #create' do
    before do
      post :create, params: params
    end

    context 'when there is no params' do
      let(:params) { }

      it 'responses with 400' do
        expect(response).to have_http_status(:bad_request)
      end
      it 'responses with error message' do
        expect(JSON.parse(response.body)['message']).to eq 'There was no data at all'
      end
    end

    context 'when file is invalid' do
      let(:params) { {name: 'demo-file', data: 'data:document/pdf;base64, aW52YWxpZCBmaWxlCg=='} }

      it 'responses with 415' do
        expect(response).to have_http_status(:unsupported_media_type)
      end

      it 'responses with error message' do
        expect(JSON.parse(response.body)['message']).to eq 'There was no valid data file'
      end
    end

    context 'when file is valid' do

    end
  end
end
