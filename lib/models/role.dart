enum Role {
  admin,
  user,
}

Role getRolesFromString(role) {
  switch (role) {
    case 'admin':
      return Role.admin;
    case 'user':
      return Role.user;
    default:
      return Role.user;
  }
}
