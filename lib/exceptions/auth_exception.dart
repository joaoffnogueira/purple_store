class AuthException implements Exception {
  static const Map<String, String> _messages = {
    'EMAIL_EXISTS': 'Este email já está sendo usado.',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida.',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'Muitas tentativas. Tente novamente mais tarde.',
    'EMAIL_NOT_FOUND': 'E-mail não encontrado.',
    'INVALID_PASSWORD': 'Senha inválida.',
    'USER_DISABLED': 'Usuário desabilitado.',
  };

  final String errorCode;
  AuthException(this.errorCode);

  @override
  String toString() {
    return _messages[errorCode] ?? 'Erro no processo de autenticação';
  }
}
