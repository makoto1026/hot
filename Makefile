build_runner:
	fvm dart run build_runner build --delete-conflicting-outputs
gen_icons:
	fvm dart run flutter_launcher_icons -f flutter_launcher_icons-dev.yaml
	fvm dart run flutter_launcher_icons -f flutter_launcher_icons-stg.yaml
	fvm dart run flutter_launcher_icons -f flutter_launcher_icons-prd.yaml