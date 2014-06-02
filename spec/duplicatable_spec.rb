require 'spec_helper'

describe ActiveAdmin::Duplicatable do

  describe "extends ResourceDSL" do
    it "by adding #duplicatable" do
      dsl = ActiveAdmin::ResourceDSL

      expect(dsl.public_instance_methods).to include(:duplicatable)
    end
  end

  it "enables form-based duplication by default" do
    dsl = ActiveAdmin::ResourceDSL.new(double 'config')

    expect(dsl).to receive(:enable_resource_duplication_via_form)

    dsl.duplicatable
  end

  it 'enables save-based duplication with option `via: :save`' do
    dsl = ActiveAdmin::ResourceDSL.new(double 'config')

    expect(dsl).to receive(:enable_resource_duplication_via_save)

    dsl.duplicatable(via: :save)
  end

end
