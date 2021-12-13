#!/usr/bin/env python3
from copy import copy
import json


# result and path should be outside of the scope of find_path to persist values during recursive calls to the function
result = []
path = []

# i is the index of the list that dict_obj is part of
def find_path(dict_obj, key, i=None):
    """
    Function to find the path of the object in nested json dict and lists.
    """
    for k, v in dict_obj.items():
        # add key to path
        path.append(k)
        if isinstance(v, dict):
            # continue searching
            find_path(v, key, i)
        if isinstance(v, list):
            # search through list of dictionaries
            for i, item in enumerate(v):
                # add the index of list that item dict is part of, to path
                path.append(i)
                if isinstance(item, dict):
                    # continue searching in item dict
                    find_path(item, key, i)
                # if reached here, the last added index was incorrect, so removed
                path.pop()
        if k == key:
            # add path to our result
            result.append(copy(path))
        # remove the key added in the first line
        if path != []:
            path.pop()


def get_path(data):
    """
    Function which joins the objects in result list and returns the command to remove objects
    """
    path = ""
    for i, value in enumerate(data):
        if i == 0:
            if isinstance(value, str):
                path = f"data.get('{value}')"
        elif i == len(data) - 1:
            path += f".pop('{value}')"
        elif isinstance(value, str):
            path += f".get('{value}')"
        elif isinstance(value, int):
            path += f"[{value}]"
    return path


def get_all_paths(result):
    """
    Add all the  object paths in path_list
    """
    path_list = []
    for value in result:
        path_list.append(get_path(value))
    return path_list


def main():

    # List with variables which would be removed from intersight response json data.
    remove_list = [
        "ClassId",
        "Moid",
        "ObjectType",
        "Ancestors",
        "ModTime",
        "Owners",
        "PermissionResources",
        "SharedScope",
        "CreateTime",
        "DomainGroupMoid",
    ]

    filename = "intersight_objects.json"
    with open(filename, "r") as f:
        data = json.load(f)

    for value in remove_list:
        find_path(data, value)

    # print(result)
    # [['Policies', 'ntp', 0, 'Timezone'], ['Policies', 'hx_dns_ntp_timezone', 0, 'Timezone']]

    # Add all the object paths to path_list
    path_list = get_all_paths(result)

    # Execute commands to remove objects from json data
    # Eval is used to convert string to command
    for cmd in path_list:
        eval(cmd)

    # Write parsed json data to file
    with open("intersight_parsed.tfvars.json", "w") as f:
        json.dump(data, f)


if __name__ == "__main__":
    main()
