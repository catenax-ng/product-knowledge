#!/bin/sh

# Copyright (c) 2022,2023 Contributors to the Eclipse Foundation
# See the NOTICE file(s) distributed with this work for additional
# information regarding copyright ownership.
#
# This program and the accompanying materials are made available under the
# terms of the Apache License, Version 2.0 which is available at
# https://www.apache.org/licenses/LICENSE-2.0.
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#
# SPDX-License-Identifier: Apache-2.0

OLD_VERSION=1.12.17-SNAPSHOT
echo Upgrading from $OLD_VERSION to $1
PATTERN=s/$OLD_VERSION/$1/g
LC_ALL=C
find ./ -type f \( -iname "*.xml" -o -iname "*.sh"  -o -iname "*.yml"  -o -iname "*.yaml"  -o -iname "*.md"  -o -iname "*.java" -o -iname "*.properties" \) -exec sed -i.bak $PATTERN {} \;