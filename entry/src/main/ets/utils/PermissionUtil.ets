import { Permissions } from '@kit.AbilityKit';

export interface PermissionResult{
  allGranted:boolean
  permissions:Record<Permissions,boolean>
}

export class PermissionUtil{


  public static check(permissions:Permissions|Permissions[]){
    let permissionList:Permissions[]=PermissionUtil.toPermissionsList(permissions)

  }

  private static toPermissionsList(permissions:Permissions|Permissions[]){
    return Array.isArray(permissions)?permissions:[permissions]
  }
}