locals {
  // Because this is a job, it does not have any private or public URLs
  // This is here to satisfy the requirements for an app
  private_urls = []
  public_urls  = []

  private_hosts = []
  public_hosts  = []
}
