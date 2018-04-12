#

config_params = yaml(content: inspec.profile.file('params.yml')).params

vpc_id = config_params['swarm-vpc-id']
swarm_managers = config_params['swarm-managers']
swarm_workers = config_params['swarm-workers']

ami_id = ENV['TF_VAR_swarm_ami_id']

control 'vpc' do
    impact 1.0
    title 'VPC config'
    desc 'The VPC should be properly configured'
    describe aws_vpc(vpc_id) do
        its('state') { should eq 'available' }
        its('cidr_block') { should eq '10.100.0.0/16' }
    end
end


control 'swarm-managers' do
    impact 1.0
    title 'Swarm Managers config'
    desc 'The swarm manager(s) should be properly configured'
    swarm_managers.each do |swarm_manager|
        describe aws_ec2_instance(name: swarm_manager) do
            it { should be_running }
            its('image_id') { should eq ami_id }
            its('vpc_id') { should eq vpc_id }
            its('instance_type') { should eq 't2.micro' }
            its('public_ip_address') { should be }
        end
    end
end


control 'swarm-workers' do
    impact 1.0
    title 'Swarm Workers config'
    desc 'The swarm worker(s) should be properly configured'
    swarm_workers.each do |swarm_worker|
        describe aws_ec2_instance(name: swarm_worker) do
            it { should be_running }
            its('image_id') { should eq ami_id }
            its('vpc_id') { should eq vpc_id }
            its('instance_type') { should eq 't2.micro' }
            its('public_ip_address') { should be }
        end
    end
end
