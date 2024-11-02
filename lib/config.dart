class Config {
  static const env = String.fromEnvironment('FLAVOR');
  static const supabaseAnon = String.fromEnvironment('SUPABASE_ANON');
  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const bool isDev = env == 'dev';
}
