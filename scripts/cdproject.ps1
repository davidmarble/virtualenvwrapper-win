function Show-Usage {
    echo ""
    echo  "switches to the project dir of the activated virtualenv"
}

if (-not (Test-Path env:VIRTUAL_ENV)) {
    echo ""
    echo "a virtualenv must be activated"
    Show-Usage
    return
}

if (-not (Test-Path env:VIRTUALENVWRAPPER_PROJECT_FILENAME)) {
    $VIRTUALENVWRAPPER_PROJECT_FILENAME = '.project'
} else {
    $VIRTUALENVWRAPPER_PROJECT_FILENAME = ($env:VIRTUALENVWRAPPER_PROJECT_FILENAME).Replace('"','')
}

if (-not (Test-Path "$($env:VIRTUAL_ENV)\$($VIRTUALENVWRAPPER_PROJECT_FILENAME)")) {
    echo ""
    echo "No project directory found for current virtualenv"
    Show-Usage
    return
}


$ENVPRJDIR = Get-Content "$($env:VIRTUAL_ENV)\$($VIRTUALENVWRAPPER_PROJECT_FILENAME)" -First 1

# If path extracted from file contains env variables, the system will not find the path.
# TODO: Add this functionality

cd $ENVPRJDIR