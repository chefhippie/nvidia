#
# Cookbook Name:: nvidia
# Attributes:: default
#
# Copyright 2013-2014, Thomas Boerger <thomas@webhippie.de>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default["nvidia"]["packages"] = %w(
  x11-video-nvidiaG03
)

case node["platform_family"]
when "suse"
  repo = case node["platform_version"]
  when /\A13\.\d+\z/
    node["platform_version"]
  when /\A42\.\d+\z/
    node["platform_version"]
  when /\A\d{8}\z/
    "42.1"
  else
    raise "Unsupported SUSE version"
  end

  default["nvidia"]["zypper"]["enabled"] = true
  default["nvidia"]["zypper"]["alias"] = "nvidia-drivers"
  default["nvidia"]["zypper"]["title"] = "Nvidia Drivers"
  default["nvidia"]["zypper"]["repo"] = "ftp://download.nvidia.com/opensuse/#{repo}/"
  default["nvidia"]["zypper"]["key"] = "#{node["nvidia"]["zypper"]["repo"]}repodata/repomd.xml.key"
end
