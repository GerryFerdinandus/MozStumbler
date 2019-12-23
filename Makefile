copy_properties:
	@if [ ! -f android/properties/private-github.properties ]; then\
		cp android/properties/private-fdroid.properties android/properties/private-github.properties;\
		touch android/properties/private-playstore.properties;\
	fi

test: libtest unittest copy_properties
	./gradlew copyTestResources
	./gradlew testGithubUnittest --info

libtest: copy_properties
	cd libraries/stumbler; ./gradlew test

unittest: copy_properties
	./gradlew assembleGithubUnittest

debug: copy_properties
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

clean: copy_properties
	rm -rf outputs
	rm -rf libraries/stumbler/build
	./gradlew clean

install_debug: copy_properties
	./gradlew installGithubDebug
