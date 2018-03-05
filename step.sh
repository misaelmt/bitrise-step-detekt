#!/usr/bin/env bash
set -ex

detekt_dir="$(mktemp -d)"
cleanup() {
  rm -rf "${detekt_dir}"
}
trap cleanup EXIT

export GIT_ASKPASS=:
git clone https://github.com/arturbosch/detekt "${detekt_dir}"

pushd "${detekt_dir}"
./gradlew build shadowJar
popd

detekt_jar="$(find "${detekt_dir}/detekt-cli/build/libs" -name "detekt-cli-*-all.jar")"
java -jar "${detekt_jar}" --input "${path_to_analyze}"
