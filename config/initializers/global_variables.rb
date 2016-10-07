# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#VALIDATIONS VARIABLES
USERNAME = /^[a-z0-9 ._]+$/
PASSWORD = /^[a-zA-Z0-9 ._]+$/
CHARS = /^[a-zA-Z]+$/
NAMES = /^[a-zA-ZñÑáéíóúÁÉÍÓÚ .,]+$/
ALPHANUMERIC = /^[a-zA-Z0-9]+$/
COMMUN_CHARS = /^[a-zA-ZñÑáéíóúÁÉÍÓÚ0-9 #:.,-]+$/
INTEGER = /^[0-9]+$/
MONEY = /\A\d+(?:\.\d{0,2})?\z/
ALL_CHARS = /./
BOOLEAN = /^t|^f/
EMAIL = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i