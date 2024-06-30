export default interface AuthorizationResult {
    serverAuthCode: string
    accessToken: string
    authorizedScopes: string[]
}