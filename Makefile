empty_properties:
	touch android/properties/private-github.properties
	touch android/properties/private-playstore.properties

test: libtest unittest empty_properties
	echo test is run
	./gradlew copyTestResources
	./gradlew testGithubUnittest --info

libtest: empty_properties
	cd libraries/stumbler; ./gradlew test

unittest: empty_properties
	./gradlew assembleGithubUnittest

debug: empty_properties
	./gradlew assembleGithubDebug

github:
	./release_check.py github
	./gradlew assembleGithubRelease
	sh rename_release.sh github-release

playstore:
	./release_check.py playstore
	./gradlew assemblePlaystoreRelease
	sh rename_release.sh playstore-release

fdroid:
	./gradlew assembleFdroidRelease
	sh rename_release.sh fdroid-release

clean: empty_properties
	rm -rf outputs
	rm -rf libraries/stumbler/build
	./gradlew clean

install_debug: empty_properties
	./gradlew installGithubDebug
