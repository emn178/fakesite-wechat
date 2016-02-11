describe Fakesite::Wechat::Base do
  before { 
    allow_any_instance_of(Time).to receive(:to_i).and_return(1441197000) 
    base.external_uri = uri
    base.params = params
    base.user = user
  }
  let(:base) { Fakesite::Wechat::Base.new :nickname => :name }
  let(:uri) { URI.parse('https://open.weixin.qq.com/connect/qrconnect?appid=wxbdc5610cc59c1631&redirect_uri=https%3A%2F%2Fpassport.yhd.com%2Fwechat%2Fcallback.do&response_type=code&scope=snsapi_login&state=3d6be0a4035d839573b04816624a415e#wechat_redirect') }
  let(:params) {
    {
      "code" => "1441197000",
      "state" => "3d6be0a4035d839573b04816624a415e",
      "openid" => "1",
      "access_token" => "T1441197000",
      "refresh_token" => "R1441197000",
      "scope" => "snsapi_login",
      "nickname" => "emn178",
      "sex" => nil,
      "province" => nil,
      "city" => nil,
      "country" => "Taiwan",
      "headimgurl" => nil
    }
  }
  let(:user) {
    OpenStruct.new(
      :id => 1,
      :email => "emn178@gmail.com",
      :name => "emn178",
      :country => "Taiwan"
    )
  }
  subject { base }

  describe "#match" do
    context "when qurconnect" do
      it { expect(Fakesite::Wechat::Base.match(uri)).to eq true }
    end

    context "when oauth2" do
      let(:uri) { URI.parse('https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxbdc5610cc59c1631&redirect_uri=https%3A%2F%2Fpassport.yhd.com%2Fwechat%2Fcallback.do&response_type=code&scope=snsapi_login&state=3d6be0a4035d839573b04816624a415e#wechat_redirect') }
      it { expect(Fakesite::Wechat::Base.match(uri)).to eq true }
    end
  end

  describe "#parameters" do
    its(:parameters) { should eq params }
  end

  describe "#return_url" do
    its(:return_url) { should eq 'https://passport.yhd.com/wechat/callback.do' }
  end

  describe "#redirect_url" do
    let!(:redirect_url) { base.redirect_url }
    it { expect(redirect_url).to eq 'https://passport.yhd.com/wechat/callback.do?code=1441197000&state=3d6be0a4035d839573b04816624a415e' }
    it { expect(Net::HTTP.get(URI.parse("https://api.weixin.qq.com/sns/oauth2/access_token?code=1441197000"))).to eq "{\"openid\":\"1\",\"access_token\":\"T1441197000\",\"refresh_token\":\"R1441197000\",\"scope\":\"snsapi_login\",\"expires_in\":7200}" }
    it { expect{Net::HTTP.get(URI.parse("https://api.weixin.qq.com/sns/oauth2/access_token?code=notfound"))}.to raise_error(WebMock::NetConnectNotAllowedError) }
    it { expect(Net::HTTP.get(URI.parse("https://api.weixin.qq.com/sns/userinfo?openid=1"))).to eq "{\"nickname\":\"emn178\",\"sex\":null,\"province\":null,\"city\":null,\"country\":\"Taiwan\",\"headimgurl\":null,\"openid\":\"1\"}" }
    it { expect{Net::HTTP.get(URI.parse("https://api.weixin.qq.com/sns/userinfo?openid=notfound"))}.to raise_error(WebMock::NetConnectNotAllowedError) }
  end
end
