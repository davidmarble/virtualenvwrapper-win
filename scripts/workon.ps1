if (-not (Test-Path env:WORKON_HOME))
{
    $WORKON_HOME = '~\Envs'
} else {
    $WORKON_HOME = ($env:WORKON_HOME).Replace('"','')
}

if (-not (Test-Path env:VIRTUALENVWRAPPER_PROJECT_FILENAME)) {
    $VIRTUALENVWRAPPER_PROJECT_FILENAME = '.project'
} else {
    $VIRTUALENVWRAPPER_PROJECT_FILENAME = ($env:VIRTUALENVWRAPPER_PROJECT_FILENAME).Replace('"','')
}

if ($args.length -eq 0) {
    echo "Pass a name to activate one of the following virtualenvs:"
    echo ==============================================================================
    (Get-ChildItem -Path $WORKON_HOME).Name
    return
}

$VENV = $args[0]

if (!(Test-Path -Path ("$($WORKON_HOME)\$($VENV)"))) {
    echo ("virtualenv $($VENV) does not exist")
    echo "Create it with 'mkvirtualenv $($VENV)'"
    return
}

if (!(Test-Path -Path ("$($WORKON_HOME)\$($VENV)\Scripts\activate.ps1") ))  {
    echo "$($WORKON_HOME)$($VENV)"
    echo "doesn't contain a virtualenv (yet)."
    echo "Create it with 'mkvirtualenv $($VENV)'"
    return
}

iex ("$($WORKON_HOME)\$($VENV)\Scripts\activate.ps1")

if (Test-Path -Path ("$($WORKON_HOME)\$($VENV)\$($VIRTUALENVWRAPPER_PROJECT_FILENAME)")) {
    iex "cdproject"
}